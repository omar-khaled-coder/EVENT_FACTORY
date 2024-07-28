import { Controller } from "stimulus";
import GLightbox from "glightbox";

export default class extends Controller {
  connect() {
    GLightbox({
      selector: ".glightbox"
    });
  }
}
