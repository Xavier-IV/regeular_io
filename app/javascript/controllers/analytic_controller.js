import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="analytic"
export default class extends Controller {
    static targets = ['surveyAction']

    connect() {
    }

    track({params}) {
        if (!params.key) return

        amplitude.track(params.key)
    }

    trackWithValue({params}) {
        if (!params.key) return

        const value = params.value
        amplitude.track(params.key, value)
    }

    storeRecord({params}) {
        const {key, value} = params
        localStorage.setItem(`public.${key}`, value)
    }

    fetchRecord({params}) {
        const {key} = params
        return localStorage.getItem(`public.${key}`)
    }
}
