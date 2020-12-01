import {BasePage} from "../components/base-page"

export default function Custom404() {
  return <BasePage>
    <div className="errorPage">
      <h1>404</h1>
      <div>
        <h2>This page could not be found.</h2>
      </div>
    </div>
  </BasePage>
}
