## ⚖️ Licensing & Operational Modes

This software is distributed under a proprietary End-User License Agreement (EULA). Please read the full [EULA](EULA.md) and [Privacy Policy](PRIVACY.md) files before downloading or using the software.

* **Evaluation Mode (Free):** Strictly for personal use, local testing, and staging/development environments (Non-Production).
    * *Note:* The free version includes a startup delay and displays informational ASCII banners in system logs.
* **Commercial Mode (Production):** Any deployment in production environments, commercial networks, or for revenue-generating activities requires a valid commercial license key.

### 🚫 Export Control Notice
By using this software, you warrant that you comply with all applicable international export control laws and economic sanctions (including US OFAC, EU, and UK regulations). Use of this software in comprehensive embargoed jurisdictions or by restricted parties is strictly prohibited.

## App description
# Ratatoskr 🐿️

**Ratatoskr** is a high-performance, omnivorous reverse proxy designed for seamless and secure TCP traffic routing. Named after the legendary messenger of Yggdrasil, it bridges connections with blazing speed, robust TLS 1.3 encryption, and flexible configuration management.

---

## 🚀 Key Features

* **Omnivorous TCP Routing:** Supports both straightforward plain-text TCP forwarding and deeply customized encrypted pipelines.
* **Unlimited quantity of routes:** Yaml-config or db-table may contain routes as many as the OS allows to occupy ports.
* **Pure TLS 1.3 Architecture:** Native and strict support for TLS 1.3 across all encrypted channels.
* **Flexible Cryptography Topologies:** Encryption can be terminated at the gateway, enforced at the client side, or applied simultaneously using distinct PKCS#12 (`.p12`) identity stores.
* **Broad Cryptographic Support:** Compatible with **RSA**, **Prime-curve (ECDSA)**, and modern **Ed25519** keys.
* **Dual-Engine Configuration:** Manage your routing via declarative `YAML` file for static setups, or drive it dynamically via a **PostgreSQL** database.
* **Instant Monitoring:** Built-in integration with **Telegram Bot API** for real-time alerting, health checks, and system notifications.

---

## ⚙️ Operational Modes & Licensing

This software is distributed under a proprietary End-User License Agreement. Please review the full [LICENSE](EULA.md) and [PRIVACY POLICY](PRIVACY.md) before deployment.

* **Evaluation Mode (Free):** Strictly for personal use, local testing, and staging/development environments (Non-Production).
   * *Note:* The evaluation version displays informational ASCII art banners in system logs and injects a brief startup delay.
* **Commercial Mode (Production):** Any deployment in production environments, commercial networks, or for revenue-generating activities requires a valid commercial license key.

---

## 📋 Requirements
* **Operating System:** Ubuntu 20.04 or newer or equivalent.
* **Architecture:** x86_64 or ARM64.
* **Zero Dependencies:** Distributed as a standalone compiled native binary. No JRE/JDK installation is required on the host machine.
* **RAM:** 134 Mb minimum requires to run.

## Extra Dependencies (Optional)
* **Database Engine:** PostgreSQL 13+ (Required only if using dynamic database-driven configuration instead of YAML).
* **Alerting:** A valid Telegram Bot Token and Chat ID (Required only for real-time alerting integration).
* **Cryptographic Materials:** Valid PKCS#12 (`.p12`) bundles containing your RSA, Prime, or Ed25519 keys for TLS 1.3 operations.

---

## 🚫 Export Control Notice

By downloading or using this software, you warrant that you comply with all applicable international export control laws and economic sanctions (including US OFAC, EU, and UK regulations). Use of this software within comprehensively embargoed jurisdictions or by restricted parties is strictly prohibited.
