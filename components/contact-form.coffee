import h from '../styles'
import {
  Pane, Label, Textarea,
  TextInputField, SegmentedControl,
  Button, Card} from 'evergreen-ui'
import {Formik, Form, Field, useField, ErrorMessage} from 'formik'

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

GrandparentNameField = (props)->

ContactFormInner = (props)->
  nameWidth = 360

  <Form className="contact-form">
    <Field as={TextInput}
      label="Full name"
      width={nameWidth}
      placeholder="Enter your full name"
      required
      name="name"
    />
    <ErrorMessage name="name" />
    <Field as={TextInput}
      label="Email address"
      type="email"
      width={nameWidth}
      placeholder="Enter your email address"
      required
      name="email"
    />
    <Field as={TextInput}
      label="Telephone number (optional)"
      name="phoneNumber"
      width={nameWidth}
      placeholder="Enter your phone number"
    />
    <Card
      className="family-connection" background="tint2"
      padding="1em" marginY="1em">
      <Label htmlFor="familyConnection">Family connection is through...</Label>
      <SegmentedField
        name="familyConnection"
        options={["Grandmother", "Grandfather"]}
      />
      <Field as={TextInput}
        label="Grandparent name"
        required
        width={nameWidth}
        name="grandparentName"
        placeholder="Enter your grandparents' name"
      />
      <Field as={TextInput}
        label="Further description"
        name="familyConnectionDescription"
        placeholder="Further describe your family connection"
      />
    </Card>
    <div className="numCopies">
      <Field as={TextInput}
        className="numCopies"
        label="Number of copies requested"
        required
        width={50}
        name="numCopies"
        placeholder="#"
      />
    </div>
    <Field as={LabeledTextArea} label="Questions or comments" name="comments" />
    <Card marginTop="1em">
      <Button type="submit" iconAfter="envelope"
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
    familyConnection: null
    numCopies: 1
    comment: ""
  }

  validate = (d)->
    console.log d

  onSubmit = (d)->
    console.log d


  h Formik, {initialValues, validate, onSubmit}, ContactFormInner


export {ContactForm}
