using System;
using System.Windows;
using System.Windows.Controls;

namespace View.Controls
{
    /// <summary>Fits every card slot inside the hand area without resizing the artwork.</summary>
    public sealed class OverlappingCardHandPanel : Panel
    {
        private const double MaximumCardSpacingRatio = 0.55;
        private Size _cardSlotSize;

        protected override Size MeasureOverride(Size availableSize)
        {
            double maximumCardWidth = 0;
            double maximumCardHeight = 0;
            foreach (UIElement cardElement in InternalChildren)
            {
                cardElement.Measure(new Size(double.PositiveInfinity, double.PositiveInfinity));
                maximumCardWidth = Math.Max(maximumCardWidth, cardElement.DesiredSize.Width);
                maximumCardHeight = Math.Max(maximumCardHeight, cardElement.DesiredSize.Height);
            }

            _cardSlotSize = new Size(maximumCardWidth, maximumCardHeight);
            double handWidth = double.IsInfinity(availableSize.Width)
                ? maximumCardWidth * InternalChildren.Count
                : availableSize.Width;
            return new Size(handWidth, maximumCardHeight);
        }

        protected override Size ArrangeOverride(Size finalSize)
        {
            int cardCount = InternalChildren.Count;
            double cardSpacing = 0;
            if (cardCount > 1)
            {
                cardSpacing = Math.Min(_cardSlotSize.Width * MaximumCardSpacingRatio,
                    Math.Max(0, finalSize.Width - _cardSlotSize.Width) / (cardCount - 1));
            }

            double occupiedWidth = cardCount > 0
                ? _cardSlotSize.Width + cardSpacing * (cardCount - 1)
                : 0;
            double firstCardOffset = Math.Max(0, (finalSize.Width - occupiedWidth) / 2);
            double cardTopOffset = Math.Max(0, finalSize.Height - _cardSlotSize.Height);
            for (int cardIndex = 0; cardIndex < cardCount; cardIndex++)
            {
                InternalChildren[cardIndex].Arrange(new Rect(
                    new Point(firstCardOffset + cardIndex * cardSpacing, cardTopOffset), _cardSlotSize));
            }

            return finalSize;
        }
    }
}
