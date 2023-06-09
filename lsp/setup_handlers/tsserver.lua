return function(_, opts)
  require("typescript").setup({ server = opts })
end
