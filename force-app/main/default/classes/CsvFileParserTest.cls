/**
 * @description Unit tests for CsvFileParser.
 * @author Vishwas Srivastav
 * @group Security, Governance & Exceptions
 */
@IsTest
private class CsvFileParserTest {

    @IsTest
    static void testParseCsv() {
        String csvData = 'Name,Rating,Industry\nAcme,Hot,Technology\nSalesforce,Warm,Cloud';
        List<List<String>> result = CsvFileParser.parseCsv(csvData);

        Assert.areEqual(3, result.size(), 'CSV matrix should contain 3 rows including header');
        Assert.areEqual('Name', result[0][0], 'First cell should be Name header');
        Assert.areEqual('Acme', result[1][0], 'Second row first cell should be Acme');
    }
}
