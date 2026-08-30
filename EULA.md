# Software License & Copyright Information

This repository contains binary distributions of the **Ratatoskr** software. The project is proprietary, and usage is governed by the End-User License Agreement (EULA) detailed below.

---

## Technical Metadata (Debian DEP-5 Format)
* **Upstream-Name:** `Ratatoskr`
* **Source:** [github](https://github.com/natsuru-san/Ratatoskr)

### Files Mapping

| Copyright Holder                                                                       | License                           | Notice / Details                                                             |
|:---------------------------------------------------------------------------------------|:----------------------------------|:-----------------------------------------------------------------------------|
| 2026 Natsuru `<natsuru-san@mail.com>`                                                  | [Ratatoskr EULA](EULA.md)         | Main application files.                                                      |
| 2026 Oracle America, Inc. and/or its affiliates                                        | `Oracle-GFTC-25`                  | Embedded runtime components (Substrate VM / GraalVM Parts).                  |
| FasterXML, Bouncy Castle, Lombok, HikariCP, PostgreSQL GDG, Liquibase, Mockito, QOS.ch | `Open-Source-Permissive-Manifest` | Automated tracking manifest for compiled third-party open-source components. |

---

<a name="eula"></a>
## END-USER LICENSE AGREEMENT (EULA) FOR RATATOSKR SERVICE

### 1. ACKNOWLEDGMENT AND ACCEPTANCE OF TERMS

* **1.1.** This End-User License Agreement ("Agreement") is a binding legal contract between you (either an individual or a single legal entity, hereinafter **"Licensee"**) and the independent software developer operating under the GitHub pseudonym "Natsuru" (**"Licensor"**), for the software product "Ratatoskr" (**"Software"**).
* **1.2.** By downloading, installing, copying, running, or otherwise using the Software, you represent that you have read, understood, and agree to be bound by all terms of this Agreement. If you do not agree, do not use the Software.

### 2. LICENSE GRANTED & OPERATIONAL MODES

* **2.1. Evaluation Mode:** The Software is provided free of charge and without time limitations strictly for personal use, local testing, and staging/development environments (**Non-Production**). In this mode, the Software may display informational ASCII art banners in system logs and inject a startup delay.
* **2.2. Commercial Mode (Production):** Any use of the Software on production environments, commercial networks, or for generating revenue requires a valid commercial license key issued by the Licensor.
* **2.3. Separation of Value & MoR Platforms:** Commercial licenses are distributed via authorized Merchant of Record (MoR) platforms (such as Lemon Squeezy, Paddle, or Gumroad). The commercial fee applies strictly to the Licensor's proprietary application logic. No fee is charged for the embedded Oracle GraalVM runtime components.

### 3. RESTRICTIONS ON USE

* **3.1. No Reverse Engineering:** Licensee shall not, and shall not permit any third party to, decompile, disassemble, reverse engineer, or attempt to derive the source code of the binary executable.
* **3.2. No pay Redistribution:** Licensee shall not rent, lease, lend, or sell the Software binaries to any third party without explicit prior written consent from the Licensor. The licensee may distribute the software without any restrictions only free of charge.

### 4. FEES AND COMMERCIAL LICENSING

* **4.1. License Purchase:** Pricing, billing, and activation details for Commercial Mode are specified on the official repository page, via authorized MoR platforms, or via direct communication with the Licensor.
* **4.2. Verification:** The Software may periodically connect to a licensing server solely to verify the validity of the commercial license key.

### 5. TERMINATION

* **5.1. Breach:** This Agreement terminates automatically if Licensee fails to comply with any of its terms.
* **5.2. Effect of Termination:** Upon termination, Licensee must immediately cease all use of the Software and destroy all copies of the binary executable.

### 6. DISCLAIMER OF WARRANTY & LIMITATION OF LIABILITY
* **6.1. AS IS:** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT. THE LICENSOR DOES NOT WARRANT THAT THE SOFTWARE WILL MEET LICENSEE'S REQUIREMENTS OR THAT ITS OPERATION WILL BE UNINTERRUPTED OR ERROR-FREE.
* **6.2. No Liability:** IN NO EVENT SHALL THE LICENSOR BE LIABLE FOR ANY CLAIM, DAMAGES, OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT, OR OTHERWISE, ARISING FROM, OUT OF, OR IN CONNECTION WITH THE SOFTWARE, OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. THIS INCLUDES, WITHOUT LIMITATION, LIABILITY FOR LOSS OF PROFITS, DATA LOSS, SYSTEM FAILURE, BUSINESS INTERRUPTION, OR ANY OTHER COMMERCIAL DAMAGES OR LOSSES, EVEN IF ADVISED OF THE POSSIBILITY THEREOF.
* **6.3. Total Cap:** IN ANY CASE, THE LICENSOR'S TOTAL AGGREGATE LIABILITY UNDER ANY PROVISION OF THIS AGREEMENT SHALL BE LIMITED TO THE AMOUNT ACTUALLY PAID BY THE LICENSEE FOR THE SOFTWARE LICENSE KEY IN THE TWELVE (12) MONTHS PRECEDING THE CLAIM.

### 7. EXPORT CONTROL & SANCTIONS COMPLIANCE
* **7.1. Compliance with Laws:** Licensee represents and warrants that they will comply with all applicable international export control laws, economic sanctions, and trade embargoes, including but not limited to regulations maintained by the United States (OFAC), the European Union, and the United Kingdom.
* **7.2. Prohibited Users:** The Software may not be downloaded, shared, hosted, or otherwise used by any individual or entity located in, or operating under the jurisdiction of, a country or territory subject to comprehensive international embargoes, or any person listed on restricted party lists (e.g., Specially Designated Nationals (SDN) List).
* **7.3. Indemnification:** Any violation of this Section 7 constitutes a material breach of the Agreement and results in immediate termination of the license without compensation.

### 8. GOVERNING LAW AND JURISDICTION
* **8.1. Governing Law:** This Agreement and any dispute or claim arising out of or in connection with it shall be governed by and construed in accordance with the laws of the State of Delaware, United States, without regard to its conflict of law principles.
* **8.2. Jurisdiction:** Any legal action, suit, or proceeding arising under or relating to this Agreement shall be brought exclusively in the state or federal courts located in the State of Delaware, United States, and each party hereby consents to the personal jurisdiction and venue of such courts.
