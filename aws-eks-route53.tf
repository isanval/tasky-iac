data "aws_route53_zone" "selected" {
  name = "neuda.net."  # Your domain name
}

data "aws_elb_hosted_zone_id" "main" {}

resource "aws_route53_record" "my_record" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "wiz"  # wiz.neuda.net
  type    = "A"

  alias {
    name                   = kubernetes_service.tasky.status[0].load_balancer[0].ingress[0].hostname
    zone_id                = data.aws_elb_hosted_zone_id.main.id
    evaluate_target_health = false
  }

  depends_on = [kubernetes_service.tasky]
}
