import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="like"
export default class extends Controller {
  static targets = ["likebtn"];


  // data-controller掛上去div的時候,connect就發動了
  connect() {    
    const { id, liked } = this.element.dataset;
    // console.log(liked);
    this.id = id;

    // dataset回傳的東西都是字串
    if (liked == "true") {
     this.likebtnTarget.textContent = "已經讚";
    } else {
     this.likebtnTarget.textContent = "尚未讚";
    }
  }
  
  toggle(e) {
    e.preventDefault();
    // 連api打api
    // 這邊backtick
    const url = `/api/v1/articles/${this.id}/like`;
    
    const token = document.querySelector("meta[name=csrf-token]").content;
  
    fetch(url, {
      method: "PATCH",
      headers: {
        'X-CSRF-Token': token,
      },    
    })
     .then((resp) => {
      return resp.json();
    })
     .then(({ liked }) => {
      if (liked) {
        this.likebtnTarget.textContent = "已經讚";
      } else {
        this.likebtnTarget.textContent = "尚未讚";
      }

      console.log(liked);

    })
      .catch((err) => {
      console.log(err);
    });
  }
}
