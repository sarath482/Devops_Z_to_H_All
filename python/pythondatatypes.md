# Python Data Types – DevOps Perspective

| Data Type             | Syntax                     | DevOps Example                                            | Where to Use                          | Where NOT to Use                                     |
| --------------------- | -------------------------- | --------------------------------------------------------- | ------------------------------------- | ---------------------------------------------------- |
| **int** (Integer)     | `x = 5`                    | `server_count = 10`                                       | Counting servers, retries, ports      | Storing decimals (use `float`)                       |
| **float** (Decimal)   | `x = 3.14`                 | `cpu_usage = 75.5`                                        | CPU %, memory usage, cost calculation | Integer-only values                                  |
| **complex**           | `x = 3 + 5j`               | Rare in DevOps                                            | Scientific calculations               | Most DevOps scripts (not needed)                     |
| **str** (String)      | `x = "hello"`              | `server_name = "prod-web-01"`                             | Hostnames, file paths, commands       | Mathematical operations                              |
| **bool** (Boolean)    | `x = True`                 | `deployment_success = False`                              | Flags for success/failure             | Storing non-binary data                              |
| **list**              | `x = [1, 2, 3]`            | `environments = ["dev", "qa", "prod"]`                    | Looping over environments/servers     | When data must not change                            |
| **tuple**             | `x = (1, 2, 3)`            | `server_details = ("prod-web-01", "10.0.0.5")`            | Fixed configs that never change       | When data changes often                              |
| **dict** (Dictionary) | `x = {"key": "value"}`     | `server_config = {"ip": "10.0.0.5", "status": "running"}` | Config files, API responses           | When order matters and no key-value structure needed |
| **set**               | `x = {1, 2, 3}`            | `unique_ips = {"10.0.0.5", "10.0.0.6"}`                   | Removing duplicates                   | Keeping order of data                                |
| **frozenset**         | `x = frozenset({1, 2, 3})` | Immutable IP sets                                         | Fixed, unique data                    | Data that needs updates                              |
| **bytes**             | `x = b"hello"`             | Reading binary log files                                  | Text processing                       | Human-readable data                                  |
| **bytearray**         | `x = bytearray(5)`         | Modifying binary data in network packets                  | Immutable binary storage              |                                                      |
| **NoneType**          | `x = None`                 | `pipeline_result = None`                                  | Variable initialization               | When you need real data                              |


#  DevOps Example Using Multiple Data Types

# Numeric
max_retries = 3  # int
cpu_threshold = 80.5  # float

# String
server_name = "prod-web-01"

# Boolean
is_deployment_successful = True

# List
servers = ["prod-web-01", "prod-web-02", "prod-db-01"]

# Tuple
credentials = ("admin", "password123")

# Dictionary
server_metrics = {
    "prod-web-01": {"cpu": 65.5, "status": "running"},
    "prod-web-02": {"cpu": 85.0, "status": "running"},
}

# Set
unique_ips = {"10.0.0.5", "10.0.0.6", "10.0.0.5"}  # duplicates auto-removed

# NoneType
error_message = None

# Example Usage
for server in servers:
    cpu = server_metrics.get(server, {}).get("cpu", 0)
    if cpu > cpu_threshold:
        print(f"{server} exceeds CPU threshold! ({cpu}%)")
