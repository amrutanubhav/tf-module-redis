#this block provisions redis

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  # parameter_group_name = aws_elasticache_parameter_group.redis-pg.name
  engine_version       = "6.x"
  security_group_ids   = [aws_security_group.allow_redis.id]
  subnet_group_name    = aws_elasticache_subnet_group.redis-sg.name
  port                 = 6379
}

# ##creates a parameter group
# resource "aws_elasticache_parameter_group" "redis-pg" {
#   name   = "roboshop-${var.ENV}-redis-pg"
#   family = "redis6.x"
# }

# creates subnet group
resource "aws_elasticache_subnet_group" "redis-sg" {
  name       = "roboshop-${var.ENV}-redis-sg"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
 
}

# resource "aws_elasticache_parameter_group" "redis-pg" {
#   name   = "roboshop-${var.ENV}-redis-pg"
#   family = "redis6.x"

#   # parameter {
#   #   name  = "activerehashing"
#   #   value = "yes"
#   # }

#   # parameter {
#   #   name  = "min-slaves-to-write"
#   #   value = "2"
#   # }
# }
# resource "aws_docdb_subnet_group" "redis-sg" {
#   name       = "roboshop-${var.ENV}-redis-sg"
#   subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

#   tags = {
#     Name = "roboshop-${var.ENV}-redis-subnet-grp"
#   }
# }



  # parameter {
  #   name  = "activerehashing"
  #   value = "yes"
  # }

  # parameter {
  #   name  = "min-slaves-to-write"
  #   value = "2"
  # }


# resource "aws_docdb_cluster" "docdb" {
#   cluster_identifier      = "roboshop-${var.ENV}-docdb"
#   engine                  = "docdb"
#   master_username         = "admin1"
#   master_password         = "roboshop1"
#   db_subnet_group_name    = aws_docdb_subnet_group.docdb.name
#   vpc_security_group_ids  = [aws_security_group.allow_mongodb.id]
# #   backup_retention_period = 5
# #   preferred_backup_window = "07:00-09:00"  #uncheck all 3 in production
# skip_final_snapshot     = true
# }



# #create cluster instances
# resource "aws_docdb_cluster_instance" "cluster_instances" {
#   count              = 1
#   identifier         = "roboshop-${var.ENV}-docdb-nodes"
#   cluster_identifier = aws_docdb_cluster.docdb.id
#   instance_class     = "db.t3.medium"
# }

# our app is not designed to work with doc db
# catalogue and cart is not designed to talk to mongodb with creds