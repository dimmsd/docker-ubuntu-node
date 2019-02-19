const express = require('express')
const demo = express()
const port = 3000

demo.get('/', (req, res) => res.send('Hello World!\n'))

demo.listen(port, () => console.log(`Demo application listening on port ${port}!`))



