const mongoose = require('mongoose')

const mentorSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i
        return value.match(re)
      },
      message: 'Please enter a valid email address',
    },
  },
  password: {
    required: true,
    type: String,
  },
  phone: {
    type: String,
  },
  gender: {
    type: String,
  },
  location: {
    type: String,
  },
  familyIncome: {
    type: Number,
  },
  languagesKnown: {
    type: String,
  },
  preferableLanguage: {
    type: String,
  },
  areaOfInterest: {
    type: String,
  },
  dateOfBirth: {
    type: Date,
  },
  levelOfEducation: {
    type: String,
  },
})

const Mentor = mongoose.model('Mentor', mentorSchema)
module.exports = Mentor
