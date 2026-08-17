data "template_file" "yuma" {
  template = "${file("templates/configuration.json.tpl")}"
}