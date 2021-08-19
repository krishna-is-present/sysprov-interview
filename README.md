Small exercise to assess interview candidates approach to development with IaC, scripting, and configuration management.

1. Using a configuration management tool of choice (i.e. Puppet, Ansible, CFEngine, etc.), provide the following configuration for a CentOS/RHEL web server:
    * Install tuned and apply throughput-performance profile
    * Install web server package (Ex. httpd or nginx) that serves a simple static page
        * Create index.html containing "Hello, World!"
    * Ensure web server service is enabled and started

2. Debug the [perl script](scripts/broken_bits.pl) and correct errors. (Tested on perl v5.16.3)
    * 4 errors total that need to be corrected

3. Convert the [perl script](scripts/broken_bits.pl) to another language of choice (python, ruby, etc.)

4. (Preferably Azure/GCP) Using terraform, implement a solution using Linux VM instance(s) running the web server configuration from exercise 1, that is resilient to downtime/outages.
