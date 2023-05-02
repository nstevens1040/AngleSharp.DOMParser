namespace AngleSharp
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using AngleSharp;
    using AngleSharp.Dom;
    //
    public class DomParser
    {
        public static IDocument GetDomDocument(string HtmlString)
        {
            Task<IDocument> doc = Task.Factory.StartNew(async () =>
            {
                IBrowsingContext context = BrowsingContext.New(Configuration.Default);
                IDocument d = await context.OpenAsync(req => req.Content(HtmlString));
                return d;
            }).Result;
            return doc.Result;
        }
    }
}
