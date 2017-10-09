//the code for this project is from the node.js
//node hero tutorial found here:
//https://blog.risingstack.com/node-hero-tutorial-getting-started-with-node-js/
const path = require('path')
const express = require('express')
const exphbs = require('express-handlebars')
//const styles = require()
const users = []

const app = express()

app.use(express.static(__dirname + '/'));

app.engine('.hbs', exphbs({
  defaultLayout: 'main',
  extname: '.hbs',
  layoutsDir: path.join(__dirname, 'views/layouts')
}))
app.set('view engine', '.hbs')
app.set('views', path.join(__dirname, 'views/layouts'))


/*app.get('/', (request, response) => {
  throw new Error('oops')
})

app.use((err, request, response, next) => {
  // log the error, for now just console.log
  console.log(err)
  response.status(500).send('Something broke!')
})*/

//storing user data in a global variable
////issues include limited RAM, memory resets with application,
////can result in stack overflow
app.post('/users', function (req, res) {
  const user = req.body
  users.push({
    name: user.name,
    age: user.age
  })
  res.send('successfully registered')
})

//storing data in a file
////scaling issues, updating has problems (locks), 
///
const fs = require('fs')
app.post('/users', function (req, res) {
  const user = req.body
  fs.appendFile('users.txt', JSON.stringify({ name: user.name, 
    age: user.age }), (err) => {
    res.send('successfully registered')
  })
})


app.get('/new_spot', (request, response) => {
  response.render('new_spot')
})

app.get('/signup', (request, response) => {
  response.render('signup')
})

app.get('/', (request, response) => {
  response.render('home', {
    name: 'John'
  })
})



app.listen(3000)
