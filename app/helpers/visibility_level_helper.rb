module VisibilityLevelHelper
  def visibility_level_color(level)
    case level
    when Gitlab::VisibilityLevel::PRIVATE
      'vs-private'
    when Gitlab::VisibilityLevel::INTERNAL
      'vs-internal'
    when Gitlab::VisibilityLevel::PUBLIC
      'vs-public'
    end
  end

  def visibility_level_description(level)
    capture_haml do
      haml_tag :span do
        case level
        when Gitlab::VisibilityLevel::PRIVATE
          haml_concat "Project access must be granted explicitly for each user."
        when Gitlab::VisibilityLevel::INTERNAL
          haml_concat "The project can be cloned by"
          haml_concat "any logged in user."
        when Gitlab::VisibilityLevel::PUBLIC
          haml_concat "The project can be cloned"
          haml_concat "without any"
          haml_concat "authentication."
        end
      end
    end
  end

  def snippet_visibility_level_description(level)
    capture_haml do
      haml_tag :span do
        case level
        when Gitlab::VisibilityLevel::PRIVATE
          haml_concat "The snippet is visible only for me"
        when Gitlab::VisibilityLevel::INTERNAL
          haml_concat "The snippet is visible for any logged in user."
        when Gitlab::VisibilityLevel::PUBLIC
          haml_concat "The snippet can be accessed"
          haml_concat "without any"
          haml_concat "authentication."
        end
      end
    end
  end

  def visibility_level_icon(level)
    case level
    when Gitlab::VisibilityLevel::PRIVATE
      private_icon
    when Gitlab::VisibilityLevel::INTERNAL
      internal_icon
    when Gitlab::VisibilityLevel::PUBLIC
      public_icon
    end
  end

  def visibility_level_label(level)
    Project.visibility_levels.key(level)
  end

  def restricted_visibility_levels(show_all = false)
    return [] if current_user.is_admin? && !show_all
    current_application_settings.restricted_visibility_levels || []
  end
end
