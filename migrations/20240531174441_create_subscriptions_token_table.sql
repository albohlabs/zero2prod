-- Add migration script here
CREATE TABLE subscriptions_tokens (
  subscriptions_token TEXT NOT NULL,
  subscriber_id uuid NOT NULL
    REFERENCES subscriptions(id) ON DELETE CASCADE,
  PRIMARY KEY (subscriptions_token)
);