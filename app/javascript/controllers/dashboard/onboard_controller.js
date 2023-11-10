import {Controller} from "@hotwired/stimulus"
import tgclient from "@sjmc11/tourguidejs" // JS

// Connects to data-controller="dashboard--onboard"
export default class extends Controller {
    connect() {
        // Create a new tour guide instance
        // const steps = [{
        //     content: "You can provide your business logo here. Or simply put any image of your store front.",
        //     title: "Business logo",
        //     target: ".guide-test",
        // }]
        //
        // const tg = new tgclient.TourGuideClient({
        //     debug: true,
        //     dialogZ: 999,
        //     steps: steps
        // })
        //
        // tg.start()
    }
}
