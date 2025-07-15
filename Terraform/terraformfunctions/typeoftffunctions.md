# Types of Functions in Terraform

Terraform provides a variety of built-in functions to help you manipulate data, perform calculations, and manage resources efficiently. These functions are grouped into several categories based on their purpose:

# 1. String Functions
Used for manipulating and formatting strings.

Examples: join, split, format, replace, substr, lower, upper, trim, regex, regexall

# 2. Collection Functions

Operate on lists, sets, and maps.

Examples: length, concat, flatten, element, index, contains, distinct, merge, lookup, keys, values, toset, tolist, tomap, compact, reverse, zipmap

# 3. Numeric Functions
Perform mathematical operations.

Examples: abs, ceil, floor, max, min, pow, signum, sqrt, log, mod, parseint, range

# 4. Encoding and Decoding Functions
Convert data between formats.

Examples: base64encode, base64decode, jsonencode, jsondecode, yamlencode, yamldecode, urlencode, urldecode

# 5. File System Functions
Read data from files.

Examples: file, filebase64, fileexists, templatefile

# 6. Date and Time Functions
Work with dates and timestamps.

Examples: timestamp, timeadd, formatdate, formatdate, now

# 7. IP Network Functions
Manipulate and validate IP addresses and CIDR blocks.

Examples: cidrsubnet, cidrhost, cidrnetmask, cidrsubnets, cidrips

# 8. Type Conversion Functions
Convert between different data types.

Examples: tostring, tonumber, tolist, tomap, toset, can, try, type

# 9. Conditional Functions
Help with conditional logic and error handling.

Examples: coalesce, coalescelist, try, can, alltrue, anytrue, contains, lookup

# 10. Specialized Functions
Include helpers for working with resources and other advanced features.

Examples: depends_on, chomp, indent, replace, slice, sort, transpose, zipmap

# Example Table: Function Categories and Usage

Category	                    Example Function	                                 Purpose/Usage Example

String	                            join	                                          join(",", ["a", "b"]) → "a,b"
Collection	                       merge	                                          merge({a=1}, {b=2}) → {a=1, b=2}
Numeric	                            max	                                              max(1, 5, 3) → 5
Encoding	                      jsonencode	                                      jsonencode({foo="bar"}) → '{"foo":"bar"}'
File System	                       file	                                              file("path/to/file.txt") → file contents
Date/Time	                      timeadd	                                           timeadd("2022-01-01T00:00:00Z", "24h") →                                                                                        "2022-01-02T00:00:00Z"
IP Network	                     cidrsubnet	                                         cidrsubnet("10.0.0.0/16", 8, 2)
Type Conversion	tostring	    tostring(123) → "123"
Conditional	                      coalesce	                                               coalesce(null, "", "foo") → ""


# Issue: If the user provides invalid names in terraform.tfvars, the following error is shown. 
Error: Invalid value for variable
│
│   on terraform.tfvars line 1:
│    1: environment = "prods"
│     ├────────────────
│     │ var.environment is "prods"
│
│ Enter the valid value for env :
│
│ This was checked by the validation rule at variables.tf:36,5-15.

# Note: remaining block of code executed

# issue 2:
 Error: Invalid variable validation condition
│ 
│   on variables.tf line 55, in variable "vm_size":
│   55:       condition = length(vm.vm_size) >=2 && length(vm.vm_size)<=20
│ 
│ The condition for variable "vm_size" must refer to var.vm_size in order to test incoming values.
# solution: inplace of condition = length(vm.vm_size) >=2 && length(vm.vm_size)<=20 replace 
condition = length(var.vm_size) >=2 && length(var.vm_size)<=20

#issue 3:
Error: Error in function call
│
│   on variables.tf line 59, in variable "vm_size":
│   59:       condition = contains(lower(var.vm_size),"standard")
│     ├────────────────
│     │ while calling contains(list, value)
│     │ var.vm_size is "standard_D2s_v3"
│
│ Call to function "contains" failed: argument must be list, tuple, or set.
╵
Releasing state lock. This may take a few moments...

# solution inplace of contains function use strcontains in variable declaration

# Issue 4:
Error: Invalid function argument
│
│   on main.tf line 32, in locals:
│   32: unique_location = toset(concat(local.user_location,local.default_location))
│     ├────────────────
│     │ while calling concat(seqs...)
│     │ local.user_location is a string
│
│ Invalid value for "seqs" parameter: all arguments must be lists or tuples; got string.
---
solution : parameters applied corretly