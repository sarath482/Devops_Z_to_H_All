# OSI Model in Azure – Layer by Layer with Examples

| OSI Layer | Layer Name   | Azure Example / Use Case                                                                     |
| --------- | ------------ | -------------------------------------------------------------------------------------------- |
| **7**     | Application  | - Azure Web Apps running over **HTTP/HTTPS**  <br> - **Azure API Management**, **DNS**       |
| **6**     | Presentation | - **TLS/SSL encryption** for secure web apps (Azure Front Door, Application Gateway)         |
| **5**     | Session      | - **Azure SignalR Service** managing real-time web socket sessions <br> - Remote Desktop     |
| **4**     | Transport    | - Azure Load Balancer (Layer 4) using **TCP/UDP** ports <br> - NSG rules allowing TCP 80     |
| **3**     | Network      | - **Azure Virtual Network (VNet)** <br> - **User Defined Routes (UDR)** <br> - **NSG rules** |
| **2**     | Data Link    | - Underlying **Ethernet** over Azure’s SDN <br> - Azure network interface (NIC) abstraction  |
| **1**     | Physical     | - **Azure Data Center hardware** <br> - Fiber optics, network cables, switches, NICs         |
