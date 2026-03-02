interface MessageProps {
  message: string;
}

export function LoadingBlock({ message }: MessageProps) {
  return <div className="state-block">{message}</div>;
}

export function ErrorBlock({ message }: MessageProps) {
  return <div className="state-block error">{message}</div>;
}

export function EmptyBlock({ message }: MessageProps) {
  return <div className="state-block muted">{message}</div>;
}
