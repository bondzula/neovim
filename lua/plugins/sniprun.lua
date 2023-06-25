-- Run code snippets from anywhere
-- TODO: improve and document this
return {
  {
    "michaelb/sniprun",
    build = "bash install.sh",
    cmd = "Sniprun",
    opts = {
      selected_interpreters = { "JS_TS_deno" },
      repl_enable = { "JS_TS_deno" },
    },
  },
}
