ActiveAdmin.register_page "Materials Overview" do
  menu parent: "Pages"

  page_action :update, method: :patch do
    @content = ManagedContent.find_by!(region: "materials-intro")

    if @content.update(params[:managed_content].permit(:body))
      flash[:success] = "Content has been successfully updated."
      redirect_to admin_materials_overview_path
    else
      messages = @content.errors.full_messages.join
      flash[:error] = "Error: " + messages
      redirect_to admin_materials_overview_path
    end
  end

  content do
    semantic_form_for(ManagedContent.find_by(region: "materials-intro"),
                      url: admin_materials_overview_update_path) do |f|
      f.inputs{ f.input :body, as: :ckeditor, label: "Intro" } +

      f.actions{ f.submit "Update Content" }
    end
  end
end
