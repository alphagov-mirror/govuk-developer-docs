class ProxyPages
  def self.resources
    publishing_api_docs +
      govuk_schema_names +
      app_docs +
      app_docs_json +
      document_types +
      supertypes
  end

  def self.publishing_api_docs
    PublishingApiDocs.pages.map do |page|
      {
        url: "/apis/publishing-api/#{page.filename}.html",
        template: "templates/publishing_api_template.html",
        frontmatter: {
          title: "Publishing API: #{page.title}",
          locals: {
            title: "Publishing API: #{page.title}",
            page: page,
          },
        },
      }
    end
  end

  def self.govuk_schema_names
    GovukSchemas::Schema.schema_names.map do |schema_name|
      schema = ContentSchema.new(schema_name)

      {
        url: "/content-schemas/#{schema_name}.html",
        template: "templates/schema_template.html",
        frontmatter: {
          title: "Schema: #{schema.schema_name}",
          content: "",
          locals: {
            title: "Schema: #{schema.schema_name}",
            description: "Everything about the '#{schema.schema_name}' schema",
            schema: schema,
          },
        },
      }
    end
  end

  def self.app_docs
    AppDocs.pages.map do |application|
      {
        url: "/apps/#{application.app_name}.html",
        template: "templates/application_template.html",
        frontmatter: {
          title: application.page_title,
          locals: {
            title: application.page_title,
            description: "Everything about the #{application.app_name} application (#{application.description})",
            application: application,
          },
        },
      }
    end
  end

  def self.app_docs_json
    AppDocs.pages.map do |application|
      {
        url: "/apps/#{application.app_name}.json",
        template: "templates/json_response.json",
        frontmatter: {
          locals: {
            payload: application.api_payload,
          },
        },
      }
    end
  end

  def self.document_types
    DocumentTypes.pages.map do |document_type|
      {
        url: "/document-types/#{document_type.name}.html",
        template: "templates/document_type_template.html",
        frontmatter: {
          title: "Document type: #{document_type.name}",
          content: "",
          locals: {
            title: "Document type: #{document_type.name}",
            description: "Everything about the '#{document_type.name}' document type",
            page: document_type,
          },
        },
      }
    end
  end

  def self.supertypes
    Supertypes.all.map do |supertype|
      {
        url: "/document-types/#{supertype.id}.html",
        template: "templates/supertype_template.html",
        content: "",
        frontmatter: {
          title: "#{supertype.name} supertype",
          locals: {
            title: "#{supertype.name} supertype",
            description: supertype.description,
            supertype: supertype,
          },
        },
      }
    end
  end
end
