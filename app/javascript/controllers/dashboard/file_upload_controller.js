import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="dashboard--file-upload"
export default class extends Controller {
    static targets = ['logoCta', 'logoCtaHover', 'logoCtaHoverMessage', 'logoCtaHoverUploadBtn', 'logoCtaHoverIconPlus', 'logoUploadContainer', 'logoUploadedContainer', 'logoFile']

    isUploading = false;

    currentFile = null;
    
    get isUploaded() {
        return this.logoFileTarget.files.length > 0;
    }


    mouseEnter() {
        this.logoCtaTarget.classList.add('hidden')
        this.logoCtaHoverTarget.classList.remove('hidden')
    }

    mouseClick() {
        this.isUploading = true
    }

    mouseLeave() {
        if (this.isUploading) return;
        this.logoCtaTarget.classList.remove('hidden')
        this.logoCtaHoverTarget.classList.add('hidden')
    }

    mouseEnterUploaded() {
        this.logoUploadedContainerTarget.classList.remove('hidden')
    }

    mouseClickUploaded() {
        this.isUploading = true
    }

    mouseLeaveUploaded() {
        if (this.isUploading) return;
        this.logoUploadedContainerTarget.classList.add('hidden')
    }

    changeFile() {
        this.isUploading = true
        if (this.logoFileTarget.files.length > 0) {
            this.currentFile = this.logoFileTarget.files[0];

            this.logoCtaHoverMessageTarget.innerHTML = this.currentFile.name
            this.logoCtaHoverUploadBtnTarget.classList.remove('hidden')
            this.logoUploadContainerTarget.classList.remove('cursor-pointer')
            this.logoCtaHoverIconPlusTargets.forEach((item) => item.classList.add('hidden'))
        }
    }
}
