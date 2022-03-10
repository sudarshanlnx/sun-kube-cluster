module "clustering" {
  source      = "../module/eks"
  clustersg   = var.clustersg
  vpcname     = var.vpcname
  pubsub01    = var.pubsub01
  pubsub02    = var.pubsub02
  #pri01       = var.pri01
  #pri02       = var.pri02
  block1      = var.block1
  block2      = var.block2
  block3      = var.block3
  block4      = var.block4
  block5      = var.block5
  block6      = var.block6
  env         = var.env
  clustername = var.clustername
}
