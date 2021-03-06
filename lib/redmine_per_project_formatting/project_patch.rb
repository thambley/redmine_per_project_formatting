require_dependency 'project'

module RedminePerProjectFormatting
  module ProjectPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        serialize :modules_for_formatting
        safe_attributes 'text_formatting', 'modules_for_formatting'
      end
    end

    module InstanceMethods
      def project_wide_formatting
        modules_for_formatting.to_a.reject(&:blank?).empty?
      end

      def module_options
        (enabled_module_names & %w[issue_tracking news documents wiki boards]
        ).map {|name| [I18n.t("project_module_" + name), name]}
      end
    end
  end

  Project.send(:include, ProjectPatch)
end
