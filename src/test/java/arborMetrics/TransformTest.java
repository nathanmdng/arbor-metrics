package arborMetrics;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.IOException;
import java.io.StringWriter;
import java.util.List;

import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.commons.io.IOUtils;
import org.json.JSONArray;
import org.json.XML;
import org.junit.Test;

public class TransformTest {

	@Test
	public void testTransform() throws IOException, TransformerException {
		Source xmlSource = getSource("patient.xml");
		Source xslt = getSource("patient.xslt");
		TransformerFactory factory = TransformerFactory.newInstance();
		Transformer transformer = factory.newTransformer(xslt);
		StreamResult result = new StreamResult(new StringWriter());
		transformer.transform(xmlSource, result);
		String resultXml = result.getWriter().toString();
		JSONArray patientJson = (JSONArray) XML.toJSONObject(resultXml).get("patient");
		String actualOutput = patientJson.toString();
		assertEquals(getExpectedOutput(), actualOutput);
		System.out.println(getExpectedOutput());
		System.out.println(actualOutput);
	}
	
	private Source getSource(String filename) throws IOException {
		return new StreamSource(getClass().getClassLoader().getResourceAsStream(filename));
	}
	
	private String getExpectedOutput() throws IOException {
		List<String> expectedLines = IOUtils.readLines(getClass().getClassLoader().getResourceAsStream("patient.json"));
		StringBuilder sb = new StringBuilder();
		for (String line: expectedLines) {
			sb.append(line.trim());
		}
		return sb.toString();
	}
}
