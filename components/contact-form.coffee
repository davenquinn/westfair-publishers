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
  {options, name} = props
  [field, meta, helpers] = useField(props)
  {value, onChange} = field

  h SegmentedControl, {
    options: options.map (d)->{value: d, label: d}
    field...
    onChange: helpers.setValue
  }

TextInput = (props)->
  h(TextInputField, {marginBottom: 8, props...})

ContactFormInner = (props)->
  fc = props.values.familyConnection
  console.log props.isValid, props.allowSubmit

  <Form className="contact-form">
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
        width={50}
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
      <div className={if fc? then "control shown" else "control hidden"}>
        <Field as={TextInput}
          label="#{fc or "Grandmother"} name"
          required
          name="grandparentName"
          placeholder={"Enter your #{fc or "Grandmother"}'s name"}
        />
      </div>
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

ContactForm = (props)->
  initialValues = {
    name: ""
    email: ""
    phoneNumber: ""
    grandparentName: ""
    familyConnectionDescription: ""
    familyConnection: "Grandmother"
    numCopies: 1
    comment: ""
  }

  [allowSubmit, setAllowSubmit] = useState(false)

  validate = (d)->
    errors = {}
    hasErrors = false
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
