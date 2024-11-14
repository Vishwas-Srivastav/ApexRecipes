/**
 * @description Apex CSV file parser converting Blob or String CSV data into headers and mapped record rows.
 * @author Vishwas Srivastav
 * @group Security, Governance & Exceptions
 */
public with sharing class CsvFileParser {

    /**
     * @description Parses raw CSV String into lines and comma-delimited columns.
     * @param csvContent Raw CSV file string.
     * @return List<List<String>> Matrix of CSV rows and column values.
     */
    public static List<List<String>> parseCsv(String csvContent) {
        List<List<String>> rows = new List<List<String>>();
        if (String.isBlank(csvContent)) {
            return rows;
        }

        List<String> lines = csvContent.split('\n');
        for (String line : lines) {
            String trimmedLine = line.trim();
            if (String.isNotBlank(trimmedLine)) {
                List<String> columns = trimmedLine.split(',');
                List<String> cleanedColumns = new List<String>();
                for (String col : columns) {
                    cleanedColumns.add(col.trim().replace('"', ''));
                }
                rows.add(cleanedColumns);
            }
        }
        return rows;
    }
}
