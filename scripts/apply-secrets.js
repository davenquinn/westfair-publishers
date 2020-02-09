#!/usr/bin/env node
/*
Load env vars from local `.env` file
in current directory (they can also
be available on the system)
*/
require("dotenv").config()
const {spawnSync} = require("child_process")

const cfg = require("../now.json")
const {env} = cfg;

for (const [env_var,v] of Object.entries(env)) {
  const secret_name = v.slice(1)
  const val = process.env[env_var]
  if (val == null) {
    throw Error(`Environment variable ${env_var} is not available.`)
  }
  console.log(`Setting secret @${secret_name} to ${val}`)
  // Recreate next secrets with this value
  spawnSync("now", ["secrets", "rm", secret_name], {stdio: 'inherit'})
  spawnSync("now", ["secrets", "add", secret_name, val], {stdio: 'inherit'})
}
