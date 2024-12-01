1. Resource 
    * Reference name
    * Type and version
    * Maps to types for easy authoring
    * Required properties
    * Common properties (name, scope, parent, properties etc…)
    * dependsOn
2. Param
    * Description
    * Min/Max/Allowed
    * Secure
3. Var
4. Output
5. Metadata
6. Expressions
    * String interpolation vs concat()
    * Functions
        - ResourceGroup()
    * [Docs](https://learn.microsoft.com/azure/azure-resource-manager/bicep/bicep-functions)
7. Parameter files
    * using
    * getSecret(subId, rg, kv, secret, \[version])
    * readEnvironmentVariable(variable, \[defaultValue])
    
