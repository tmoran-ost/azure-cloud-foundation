#Environment names
environment_prefix = "global"

ost_admins_group = "OSTAdmins"

primary_location = {
  name   = "East US"
  prefix = "eus"
}

tags = {
  environment = "global"
  category    = "DevOps"
  created-by  = "terraform"
}

environments = {
  shared = {
    prefix  = "shared"
    sub     = "abb82d8d-8e09-4f86-b9de-658026c56b11"
    mg_name = "Platform"
  }
  corp-prd = {
    prefix  = "corp-prd"
    sub     = "b35e028a-790c-4609-a029-eb03cadb6d64"
    mg_name = "Corp"
  }
  corp-nonprd = {
    prefix  = "corp-nonprd"
    sub     = "016e86b2-f837-4456-83c6-db7e2a7b360e"
    mg_name = "Corp"
  }
}