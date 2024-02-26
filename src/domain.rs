use unicode_segmentation::UnicodeSegmentation;

pub struct SubscriberName(String);

pub struct NewSubscriber {
    pub email: String,
    pub name: SubscriberName,
}

impl AsRef<str> for SubscriberName {
    // pub fn inner_ref(&self) -> &str {
    // The caller gets a shared reference to the inner string.
    // This gives the caller **read-only** access,
    // they have no way to compromise our invariants!
    fn as_ref(&self) -> &str {
        &self.0
    }
}

impl SubscriberName {
    pub fn parse(s: String) -> Result<SubscriberName, String> {
        let is_empty_or_whitespace = s.trim().is_empty();

        // A grapheme is defined by the Unicode standard as a "user-perceived"
        // character: `å` is a single grapheme, but it is composed of two characters
        // (`a` and `̊`).
        //
        // `graphemes` returns an iterator over the graphemes in the input `s`.
        // `true` specifies that we want to use the exte
        // the recommended one.
        let is_too_long = s.graphemes(true).count() > 256;

        let forbidden_characters = [
            '/', '(', ')', '"', '<', '>', '\\', '&', ';', ':', '{', '}', '[',
            ']', '|', '@', '^', ',',
        ];
        let contains_forbidden_characters =
            s.chars().any(|g| forbidden_characters.contains(&g));

        if is_empty_or_whitespace
            || is_too_long
            || contains_forbidden_characters
        {
            panic!("{} is not a valid subscriber name.", s);
        }

        Ok(Self(s))
    }
}
