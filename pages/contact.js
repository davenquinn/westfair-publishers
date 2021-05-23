import { BasePage } from "../components/base-page";
import { CoverImage, ByFirstLightCover } from "../components/images";
import { useState } from "react";
import dynamic from "next/dynamic";

// Need to dynamically import the form to make sure that styles are resolved correctly
const ContactForm = dynamic(
  () => import("../components/contact-form").then((d) => d.ContactForm),
  { ssr: false }
);

export default function ContactPage() {
  const [book, setBook] = useState("By First Light");

  //const book = "Always with Spirit";

  return (
    <BasePage>
      {book == "Always with Spirit" ? <CoverImage /> : null}
      {book == "By First Light" ? <ByFirstLightCover /> : null}
      <div className="purchase-request-form">
        <p>
          Use this form to request to purchase either of our in-print titles, or
          with questions and comments. Pricing information can be found on the{" "}
          <a href="/how-to-order">How to order</a> page. You can also find us at
          440-937-2766 between noon and 6 pm Eastern time.
        </p>
        <h2>Purchase request form</h2>
        <ContactForm book={book} setBook={setBook} />
      </div>
    </BasePage>
  );
}
