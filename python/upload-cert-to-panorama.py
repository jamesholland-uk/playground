import requests
import xml.etree.ElementTree as ET
from urllib3.exceptions import InsecureRequestWarning


class Panorama:
    def __makeapi_request(self, url, data="", files=""):
        try:
            requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)
            response = requests.post(
                url, data=data, files=files, verify=False, timeout=10
            )
            response.raise_for_status()
        except requests.exceptions.ConnectTimeout as err:
            print("connection error")
            exit(1)
        except requests.HTTPError as err:
            self.error = err
            return self.error
        except BaseException:
            dom = ET.fromstring(response.content)
            self.error = dom.find(".//msg").text
            return self.error
        else:
            self.response_xml = response.content
            self.response_httpcode = response.status_code
            return self.response_xml

    def import_cert(self, certName):
        files = {"file": open(certName, "rb")}
        url = f"https://{self.ip}/api/?"
        params = {
            "type": "import",
            "category": "certificate",
            "certificate-name": certName,
            "format": "pem",
            "key": self.panapikey,
        }
        self.__makeapi_request(url, files=files, data=params)

    ip = "redacted"
    panapikey = "redacted"


def main():
    rama = Panorama()
    rama.import_cert("test.crt")


if __name__ == "__main__":
    main()
