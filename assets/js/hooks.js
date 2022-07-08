let Hooks = {};

Hooks.InfiniteScroll = {
  mounted() {
    console.log("Footer added to DOM!", this.el);
    this.observer = new IntersectionObserver((entries) => {
      const entry = entries[0];
      if (entry.isIntersecting) {
        console.log("Footer is visible!");
        this.pushEvent("load-more");
      }
    });

    this.observer.observe(this.el);
  },
  updated() {
    const pageNumber = this.el.dataset.pageNumber;
    console.log("updated", pageNumber);
  },
  destroyed() {
    this.observer.disconnect();
  },
};

import Pikaday from "pikaday";

// Define a mounted callback and instantiated a
// flatpickr instance using this.el as the element.
// When a date is picked, use this.pushEvent()
// to push an event to the LiveView with the chosen
// date string as the payload.
Hooks.DatePicker = {
  mounted() {
    var picker = new Pikaday({
      field: this.el,
      onSelect: this.handleDatePicked.bind(this),
    });
  },

  handleDatePicked(pick) {
    this.pushEvent("dates-picked", pick.toISOString());
    this.el.value = pick.toLocaleDateString();
  },
};

export default Hooks;
