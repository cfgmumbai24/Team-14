const mongoose = require('mongoose')
const { courseSchema } = require('./courses')

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  role:{
    required:true,
    type:String,
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
  courses: [
    {
      courseSchema,
    },
  ],
  mentor: {type: mongoose.Schema.Types.ObjectId,}
})

const User = mongoose.model('User', userSchema)
module.exports = User
