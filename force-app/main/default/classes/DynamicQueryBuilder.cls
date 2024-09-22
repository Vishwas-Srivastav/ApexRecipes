/**
 * @description Dynamic SOQL query builder enforcing WITH USER_MODE and bind variables via Database.queryWithBinds.
 * @author Vishwas Srivastav
 * @group Dynamic Apex & Schema Describe
 */
public with sharing class DynamicQueryBuilder {

    private String sObjectName;
    private Set<String> fields = new Set<String>();
    private String whereClause;

    /**
     * @description Constructor setting target SObject type.
     * @param sObjectName SObject API name.
     */
    public DynamicQueryBuilder(String sObjectName) {
        this.sObjectName = sObjectName;
    }

    /**
     * @description Selects field API names to query.
     * @param fieldList Collection of field names.
     * @return DynamicQueryBuilder Current instance for method chaining.
     */
    public DynamicQueryBuilder selectFields(Set<String> fieldList) {
        if (fieldList != null) {
            this.fields.addAll(fieldList);
        }
        return this;
    }

    /**
     * @description Sets WHERE filter clause.
     * @param filter Filter condition string.
     * @return DynamicQueryBuilder Current instance for method chaining.
     */
    public DynamicQueryBuilder setWhere(String filter) {
        this.whereClause = filter;
        return this;
    }

    /**
     * @description Executes dynamic query using Database.queryWithBinds.
     * @param bindMap Map of variable names to bind values.
     * @return List<SObject> Query execution results.
     */
    public List<SObject> executeWithBinds(Map<String, Object> bindMap) {
        if (String.isBlank(this.sObjectName) || this.fields.isEmpty()) {
            return new List<SObject>();
        }

        String queryStr = 'SELECT ' + String.join(new List<String>(this.fields), ', ') + 
                          ' FROM ' + this.sObjectName;

        if (String.isNotBlank(this.whereClause)) {
            queryStr += ' WHERE ' + this.whereClause;
        }

        queryStr += ' WITH USER_MODE';

        Map<String, Object> binds = (bindMap != null) ? bindMap : new Map<String, Object>();
        return Database.queryWithBinds(queryStr, binds, AccessLevel.USER_MODE);
    }
}
