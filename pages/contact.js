import { BasePage } from "../components/base-page";
import { ContactForm } from "../components/contact-form";
import { CoverImage } from "../components/images";
import {useState} from "react"

export default function ContactPage() {

  const [book, setBook] = useState("Always with Spirit");

  return <BasePage>
    <CoverImage />
    <div className="purchase-request-form">
      <p>
      Use this form to contact us to request to purchase either of our in-print titles,
      or with questions and comments. Pricing information can be
      found on the <a href="/how-to-order">How to order</a> page.
      </p>
      <ContactForm book={book} setBook={setBook} />
    </div>
  </BasePage>
}
