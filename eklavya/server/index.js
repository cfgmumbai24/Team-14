// IMPORT FROM PACKAGES
require('dotenv').config()
const express = require('express')
const mongoose = require('mongoose')

// IMPORT FROM OTHER FILES
const authRouter = require('./routes/authRouter')
const courseRouter = require('./routes/courseRouter')
const userRouter = require('./routes/userRouter')
const formRouter = require('./routes/formRouter')
const surveyRouter = require('./routes/surveyRouter')

// INIT
const PORT = process.env.PORT || 3000
const app = express()
const DB = process.env.MONGO_URL

// MIDDLEWARE
app.use(express.json())
app.use(authRouter)
app.use(courseRouter)
app.use(userRouter)
app.use(formRouter)
app.use(surveyRouter)

// CONNECTIONS

mongoose
  .connect(DB)
  .then(() => {
    console.log('connection successful')
  })
  .catch((e) => {
    console.log(e)
  })

app.listen(PORT, () => {
  console.log(`connect at port ${PORT}`)
})
