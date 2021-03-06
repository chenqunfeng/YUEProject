Template.changeProfile.events {
	'change .avatar-input': (e)!->

		e.preventDefault!

		if typeof FileReader is undefined
			alert '抱歉，你的浏览器不支持预览功能'

		reader = new FileReader()
		file = e.target.files[0]
		reader.readAsDataURL file
		reader.onload = (e)!->
			$ '#cover' .attr 'src', reader.result

	"submit form": (e) ->
		e.prevent-default!

		avatar = $(e.target).find('[name=avatar]')[0].files

		$(".login-register").form {
			nickname: {
				identifier : 'nickname'
				rules: [
					{
						type : 'empty'
						prompt : 'Please enter your nickname'
					}
				]
			}
			mail: {
				identifier : 'mail'
				rules: [
					{
						type : 'email'
						prompt : 'Please enter a valid email address'
					}
				]
			}
		}

		$(".login-register .segment") .addClass "error"

		profile = {
			nickname: $(e.target).find '[name=nickname]' .val!
			sex: $(e.target).find '[name=sex]' .val!
			tel: $(e.target).find '[name=tel]' .val!
			qq: $(e.target).find '[name=qq]' .val!
			mail: $(e.target).find '[name=mail]' .val!
			avatarId: null
		}
		

		User.change-information(profile, (error) ->
			if not error
				UploadAvatar.insert avatar
				Router.go '/'
			)
}
