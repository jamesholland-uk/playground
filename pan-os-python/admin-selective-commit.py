from panos.panorama import Panorama, PanoramaCommit

admin_list = ["user2"]
pano = Panorama("192.168.1.1", "admin", "the_password")
command = PanoramaCommit("Commit for just these admins", admins=admin_list)

pano.commit(command)
