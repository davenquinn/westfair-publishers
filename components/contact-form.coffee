import h from '../styles'
import {
  Pane, Label, Textarea,
  TextInputField, SegmentedControl,
  Button, Card, toaster} from 'evergreen-ui'
import {Formik, Form, Field, useField, ErrorMessage} from 'formik'
import {post} from 'axios'
import {useState} from 'react'

LabeledTextArea = (props)->
  {label, placeholder, name} = props
  <div>
    <Label
      htmlFor="comment"
      marginBottom={4}
      display="block">{label}</Label>
    <Field as={Textarea}
      id="comment"
      name={name}
      placeholder="Enter up to 1000 characters">
    </Field>
  </div>

SegmentedField = (props)->
  {options, name, className} = props
  [field, meta, helpers] = useField(props)
  {value, onChange} = field

  className ?= ""

  h SegmentedControl, {
    className,
    options: options.map (d)->{value: d, label: d}
    field...
    onChange: helpers.setValue
  }

TextInput = (props)->
  h(TextInputField, {marginBottom: 8, props...})

ContactFormInner = (props)->
  fc = props.values.familyConnection

  <Form className="contact-form">
    <SegmentedField
      name="book"
      className="large"
      options={["Always with Spirit", "By First Light"]}
    />
    <Field as={TextInput}
      label="Full name"
      placeholder="Enter your full name"
      required
      name="name"
    />
    <ErrorMessage name="name" />
    <Field as={TextInput}
      label="Email address"
      type="email"
      placeholder="Enter your email address"
      required
      name="email"
    />
    <Field as={TextInput}
      label="Telephone number (optional)"
      name="phoneNumber"
      placeholder="Enter your phone number"
    />
    <div className="numCopies">
      <Field as={TextInput}
        className="numCopies"
        label="Copies requested"
        required
        name="numCopies"
        placeholder="#"
      />
    </div>
    <Card
      className="family-connection" background="tint2"
      padding="1em" marginY="1em">
      <Label htmlFor="familyConnection">Family connection is through...</Label>
      <SegmentedField
        name="familyConnection"
        options={["Grandmother", "Grandfather"]}
      />
      <Field as={TextInput}
        label="Grandmother name (including maiden name)"
        required={fc=="Grandmother"}
        name="grandmotherName"
        placeholder={"Enter your Grandmother's name"}
      />
      <Field as={TextInput}
        label="Grandfather name"
        required={fc=="Grandfather"}
        name="grandfatherName"
        placeholder={"Enter your Grandfather's name"}
      />
      <Field as={TextInput}
        label="Further description (optional)"
        name="familyConnectionDescription"
        placeholder="Further describe your family connection"
      />
    </Card>
    <Field as={LabeledTextArea} label="Questions or comments" name="comments" />
    <Card marginTop="1em">
      <Button type="submit" iconAfter="envelope"
        disabled={not (props.isValid and props.allowSubmit)}
        appearance="primary" intent="success">Send</Button>
    </Card>
  </Form>

ContactForm = ({book = "By First Light", setBook})->
  initialValues = {
    name: ""
    email: ""
    book
    phoneNumber: ""
    grandmotherName: ""
    grandfatherName: ""
    familyConnectionDescription: ""
    familyConnection: "Grandmother"
    numCopies: 1
    comment: ""
  }

  [allowSubmit, setAllowSubmit] = useState(false)

  validate = (d)->
    errors = {}
    hasErrors = false
    if d.book != book and setBook?
      setBook(d.book)

    for field in ['name', 'email', "grandparentName"]
      if d[field] == ""
        errors[field] = 'required'
        hasErrors = true
    if not hasErrors
      setAllowSubmit(true)
    return errors


  onSubmit = (d, {setSubmitting})->
    toaster.notify("Sending your message...")
    console.log(d)
    try
      res = await post('/api/contact-form', d)
      toaster.closeAll()
      if res.status == 200
        setAllowSubmit(false)
        toaster.success("Message successfully sent!")
      else
        throw "Invalid API response"
    catch err
      toaster.closeAll()
      toaster.danger("Error: #{err}")

  h Formik, {
    initialValues,
    validate,
    onSubmit
  }, (formikProps)->
    h ContactFormInner, {
      formikProps...
      allowSubmit
    }


export {ContactForm}
