ActiveAdmin.register Homepage do
  menu label: "Homepage", parent: "Pages", priority: 1
  actions :all, except: [:create, :destroy]

  permit_params :welcome, :update_notes,
    :articles_intro,
    :lessons_intro,
    :materials_intro,
    :blog_intro,
    featured_topic_content_attributes: [
      :id, :content_id, :position
    ],
    featured_article_content_attributes: [
      :id, :content_id, :position
    ],
    featured_material_content_attributes: [
      :id, :content_id, :position
    ],
    featured_blog_post_content_attributes: [
      :id, :content_id, :position
    ]

  controller do
    def index
      redirect_to edit_admin_homepage_path(Homepage.take)
    end
  end

  breadcrumb do
    [link_to("Admin", "/admin"), link_to("Homepage")]
  end

  form do |f|
    inputs do
      semantic_errors *f.object.errors.keys

      input :welcome, as: :ckeditor
      input :update_notes, as: :ckeditor
    end

    inputs "Articles" do
      input :articles_intro, as: :ckeditor

      li do
        articles = Article.order(created_at: :desc)
        reorderable_inputs "Featured Articles",
                           :featured_article_content, f: f do |sf|
          sf.input :content, collection: articles,
                   input_html: { class: "select2" }
        end
      end
    end

    inputs "Lessons" do
      input :lessons_intro, as: :ckeditor

      li do
        topics = Topic.order(created_at: :desc)
        reorderable_inputs "Featured Topics",
                           :featured_topic_content, f: f do |sf|
          sf.input :content, collection: topics,
                   input_html: { class: "select2" }
        end
      end
    end

    inputs "Training Materials" do
      input :materials_intro, as: :ckeditor

      li do
        materials = Material.order(created_at: :desc)
        reorderable_inputs "Featured Materials",
                           :featured_material_content, f: f do |sf|
          sf.input :content, collection: materials,
                   input_html: { class: "select2" }
        end
      end
    end

    inputs "Blog" do
      input :blog_intro, as: :ckeditor

      li do
        blog_posts = BlogPost.order(published_at: :desc)
        reorderable_inputs "Featured Blog Posts",
                           :featured_blog_post_content, f: f do |sf|
          sf.input :content, collection: blog_posts,
                   input_html: { class: "select2" }
        end
      end
    end

    f.actions
  end
end
