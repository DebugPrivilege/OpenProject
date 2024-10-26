# Frequently Asked Questions

- **Q:** I’ve received a high or critical severity alert in my EDR on a machine that I suspect is compromised. What should I do next?  
  **A:** Run `CyLR.exe` (a forensic tool) via Live Response or another method to collect some forensic data. Once complete, ensure you retrieve the ZIP file containing this data. Afterward, you can proceed to isolate the server from the network.

- **Q:** Antivirus solutions sometimes generate false positives. When should I take alerts more seriously during an investigation?  
  **A:** Florian Roth created a helpful Antivirus Cheat Sheet that can assist professionals with initial triage. You can find it [here](https://www.nextron-systems.com/?s=antivirus).

- **Q:** I’ve called in an Incident Response firm for help. What should I prepare to make the investigation go as smoothly as possible?  
  **A:** Have a few team members with system access ready to collect the requested forensic data for the IR team. If you have an EDR solution, creating temporary accounts for the IR team to access it directly will also streamline the process.



# Common mistake

Imagine you’re a small or medium business with a limited budget for full-time staff. Then, on a Monday morning, you get an alert from your EDR solution about suspicious activity on your Exchange server. It looks like the attacker is actively moving within your environment, and the natural reaction is to quickly shut down the server to contain the attack. But this is where things can go wrong, shutting down the server at this point would mean losing valuable forensic data and possibly other critical information needed to understand the full extent of the attack.

![image](https://github.com/user-attachments/assets/028fc209-4aeb-4f07-86f9-cd381d78c153)


---

## Why do we need to collect forensic data?

We need to collect forensic data before starting recovery because it captures important details about the attack and how it started, which systems were affected, and whether any data was taken. If we skip this step, we might lose evidence that shows the full picture, leaving us open to further attacks or missing the root cause. It also helps meet legal requirements and ensures we’re not just putting a temporary fix in place.

---

## Call an Incident Response firm

Collecting forensic data is essential, as it supports the investigation during incident response. Even if you lack the resources to analyze thousands of systems, capturing data from the initial machine you suspect is compromised provides a starting point with valuable insights. From there, you can bring in IR professionals who specialize in full forensic analysis, helping you gain a broader picture of how the attack started, what systems were affected, and what actions the attacker took. This comprehensive view ensures a thorough response and helps address any vulnerabilities used in the attack.
