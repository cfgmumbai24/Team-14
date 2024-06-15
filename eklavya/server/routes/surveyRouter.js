const express = require('express')
const surveyRouter = express.Router()
const Survey = require('../models/survey')

surveyRouter.post('/api/surveys', async (req, res) => {
  try {
    console.log(req.body)
    const survey = new Survey(req.body)
    await survey.save()
    res.status(201).send(survey)
  } catch (error) {
    console.log(error)
    res.status(400).send(error)
  }
})

module.exports = surveyRouter
