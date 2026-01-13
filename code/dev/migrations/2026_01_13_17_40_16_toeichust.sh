curl -i -X POST http://localhost:8001/plugins \
--data "name=bot-detection" \
--data "config.deny[]=Assetnote" \
--data "config.deny[]=python-httpx" \
--data "config.deny[]=CMS-Checker" \
--data "config.deny[]=BadBot/1.0" \
--data "config.deny[]=.*Scrapy.*"
