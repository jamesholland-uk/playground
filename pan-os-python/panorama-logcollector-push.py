import panos
import os

from panos import panorama
from panos.panorama import Panorama
from panos.panorama import PanoramaCommitAll


def main():

    # Define connectivity to Panorama through environment variables, for example:
    # export PANOS_HOSTNAME=my.panorama.local
    # export PANOS_USERNAME=admin
    # export PANOS_PASSWORD=abc123abc123
    HOSTNAME = os.environ.get("PANOS_HOSTNAME")
    USERNAME = os.environ.get("PANOS_USERNAME")
    PASSWORD = os.environ.get("PANOS_PASSWORD")

    # Define Panorama
    panorama = Panorama(HOSTNAME, USERNAME, PASSWORD)

    cmd = PanoramaCommitAll(
        style="log collector group",
        name="log-coll-grp",
        include_template=False,
        force_template_values=False,
    )
    sync = True
    sync_all = True

    result = panorama.commit(cmd=cmd, sync=sync, sync_all=sync_all)

    print(result)

    # Exit with status
    if not sync:
        # When sync is False only jobid is returned
        # commit_results["jobid"] = int(result)
        print(int(result))
    elif not result["success"]:
        # The commit failed
        # module.fail_json(msg=" | ".join(result["messages"]))
        print("failed")
    else:
        # The commit succeeded
        # commit_results["changed"] = True
        # commit_results["jobid"] = result["jobid"]
        print(result["jobid"])


if __name__ == "__main__":
    main()
