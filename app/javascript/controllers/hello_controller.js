import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  go(e){
  // 拿cc裡面的東西
  const { cc } = e.detail;

  this.element.textContent = cc;
    // 固定的寫法this.element, controller掛在div自己

}
}
